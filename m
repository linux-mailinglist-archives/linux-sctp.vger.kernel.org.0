Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76424447614
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Nov 2021 22:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhKGV33 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 7 Nov 2021 16:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbhKGV33 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Nov 2021 16:29:29 -0500
X-Greylist: delayed 997 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 Nov 2021 13:26:46 PST
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC2C061570
        for <linux-sctp@vger.kernel.org>; Sun,  7 Nov 2021 13:26:45 -0800 (PST)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.89)
        (envelope-from <laforge@gnumonks.org>)
        id 1mjpQS-0007nm-Q6
        for linux-sctp@vger.kernel.org; Sun, 07 Nov 2021 22:10:04 +0100
Received: from laforge by localhost.localdomain with local (Exim 4.95)
        (envelope-from <laforge@gnumonks.org>)
        id 1mjpQN-003zFL-3M
        for linux-sctp@vger.kernel.org;
        Sun, 07 Nov 2021 22:09:59 +0100
Date:   Sun, 7 Nov 2021 22:09:59 +0100
From:   Harald Welte <laforge@gnumonks.org>
To:     linux-sctp@vger.kernel.org
Subject: SCTP <= 500 pps unless SCTP_NODELAY set (was: Expected SCTP DATA
 chunk per second performance)
Message-ID: <YYhAp8jG0dvxi5bU@nataraja>
References: <20200302093532.GE43827@nataraja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302093532.GE43827@nataraja>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dear list,

after quite some time I'm again involved in a project that involved performance
testing of SCTP based protocols.

Unfortuantely it seems that the problems I reported in March 2020 on kernel 5.4.19
still persist at least up to 5.10.46

Using the same program from that old thread, I can not reach more than 500 DATA
chunks per second unless the SCTP_NODELAY option set].  When I set SCTP_NODELAY,
I'm reaching up to 77k DATA chunks per second on my venerable Thinkpad x260.

So I still think there is the fundamental problem:

  Nagle should batch up multiple DATA chunks in each packet, but it should not
  reduce the sending rate to a staggering 0.6% of the throughput without nagle

Can anybody let me know from which kernel version onwards this problem was addressed,
if any?

In general, it is of course useful to have Nagle enabled:  The expectation is that
it would batch up DATA chunks until the MTU is reached to ensure fewer larger packets.

When Nagle is disabled with SCTP_NODELAY, it is one IP packet per DATA chunk, which
is of course quite suboptimal in many traditional SCTP use cases such as SIGTRAN
where the encapsulated SS7 messages are unlikely to be > 256 bytes each.

Regards,
	Harald

On Mon, Mar 02, 2020 at 10:35:32AM +0100, Harald Welte wrote:
> Hi!
> 
> I've been trying to implement some DIAMETER load testing, and I discovered that
> it's apparently not my application layer code that is throttling the rate,
> but the kernel SCTP stack.  I currently cannot get to more than 500 SCTP data
> chunks per second on a 5.4.19 kernel (happy to try other versions).
> 
> The most simplistic setup to reproduce is:
> * run a single-threaded SCTP server and SCTP client on the same machine
> * use loopback / localhost for communication
> * have the transmitter continuously transmit sctp_sendmsg() of 100-200 bytes
> * have the receiver just sctp_recvmsg() and discard the data
> * use a single stream in a single association for now to establish a base-line
> 
> Whether I use a complex diameter stack and test framework or whether I use a
> simplistic 120 line C program that just transmits small data chunks, the
> rate always is limited to about 500 DATA chunks per second.
> 
> In wireshark, I can see that up to 9 DATA chunks are aggregated into each SCTP
> packet.  However, it typically takes the stack 203-201ms to send a SACK to each
> of those packets.  Only after that SACK is received, it seems the sender is
> transmitting more DATA chunks in the next packet.
> 
> I wonder if this is expected behavior?  As far as I understand, SCTP only has
> a congestion window based on number of bytes, and not on number of chunks. The
> windows as per INIT/INIT_ACK is at 160496 bytes, while 144 bytes * 9 chunks is
> only 1296 bytes, i.e. the window cannot be full at all.
> 
> Any ideas what's happening here and how to increase the throughput in terms of
> number of DATA chunks per second?
> 
> A demo program is attached for your reference
> 
> Thanks in advance.
> 
> Regards,
> 	Harald
> 
> -- 
> - Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
> ============================================================================
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. A6)

> /*
>  * Simple SCTP test program, original version by Daniel Mack
>  * at https://gist.github.com/zonque/7d03568eab14a2bb57cb
>  *
>  * Modified in 2020 by Harald Welte <laforge@gnumonks.org> for
>  * - DATA chunk rate testing.
>  * - initial support for userspace SCTP stack testing
>  *
>  * Compile:
>  *
>  *   gcc sctptest.c -o server -lsctp -Wall
>  *   ln -s server client
>  *
>  * Invoke:
>  *
>  *   ./client
>  *   ./server
>  */
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <libgen.h>
> #include <time.h>
> #include <sys/socket.h>
> #include <sys/types.h>
> #include <netinet/in.h>
> #include <arpa/inet.h>
> 
> #define _GNU_SOURCE
> #include <getopt.h>
> 
> #define HAVE_KERNEL_SCTP
> 
> #ifdef HAVE_KERNEL_SCTP
> #include <netinet/sctp.h>
> #define ext_socket socket
> #define ext_bind bind
> #define ext_setsockopt setsockopt
> #define ext_listen listen
> #define ext_accept accept
> #define ext_close close
> #define ext_connect connect
> #else
> /* sctplib + socketapi */
> #include <ext_socket.h>
> #include <sctp.h>
> #endif
> 
> #define MY_PORT_NUM 62324
> 
> /* compute differece between two timespec */
> static void timespec_diff(const struct timespec *start, const struct timespec *stop,
> 			  struct timespec *result)
> {
> 	if ((stop->tv_nsec - start->tv_nsec) < 0) {
> 		result->tv_sec = stop->tv_sec - start->tv_sec - 1;
> 		result->tv_nsec = stop->tv_nsec - start->tv_nsec + 1000000000;
> 	} else {
> 		result->tv_sec = stop->tv_sec - start->tv_sec;
> 		result->tv_nsec = stop->tv_nsec - start->tv_nsec;
> 	}
> }
> 
> static void die(const char *s) {
> 	perror(s);
> 	exit(1);
> }
> 
> static void server(int argc, char **argv)
> {
> 	struct sockaddr_in servaddr = {
> 		.sin_family = AF_INET,
> 		.sin_addr.s_addr = htonl(INADDR_ANY),
> 		.sin_port = htons(MY_PORT_NUM),
> 	};
> 	struct sctp_initmsg initmsg = {
> 		.sinit_num_ostreams = 5,
> 		.sinit_max_instreams = 5,
> 		.sinit_max_attempts = 4,
> 	};
> 	struct sctp_sndrcvinfo sndrcvinfo;
> 	int listen_fd, conn_fd, flags, ret, in;
> 
> 	listen_fd = ext_socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
> 	if (listen_fd < 0)
> 		die("socket");
> 
> 	ret = ext_bind(listen_fd, (struct sockaddr *) &servaddr, sizeof(servaddr));
> 	if (ret < 0)
> 		die("bind");
> 
> 	ret = ext_setsockopt(listen_fd, IPPROTO_SCTP, SCTP_INITMSG, &initmsg, sizeof(initmsg));
> 	if (ret < 0)
> 		die("setsockopt");
> 
> 	ret = ext_listen(listen_fd, initmsg.sinit_max_instreams);
> 	if (ret < 0)
> 		die("listen");
> 
> 	for (;;) {
> 		char buffer[1024];
> 		unsigned int num_chunks_rcvd;
> 
> 		printf("Waiting for connection\n");
> 		fflush(stdout);
> 
> 		conn_fd = ext_accept(listen_fd, (struct sockaddr *) NULL, NULL);
> 		if(conn_fd < 0)
> 			die("accept()");
> 
> 		printf("New client connected\n");
> 		fflush(stdout);
> 		num_chunks_rcvd = 0;
> 
> 		while (1) {
> 			in = sctp_recvmsg(conn_fd, buffer, sizeof(buffer), NULL, 0, &sndrcvinfo, &flags);
> 			if (in <= 0)
> 				break;
> 			num_chunks_rcvd++;
> 		}
> 
> 		printf("Server: Received %u chunks, closing\n", num_chunks_rcvd);
> 		fflush(stdout);
> 
> 		ext_close(conn_fd);
> 	}
> }
> 
> static void client(int argc, char **argv) {
> 	struct sockaddr_in servaddr = {
> 		.sin_family = AF_INET,
> 		.sin_port = htons(MY_PORT_NUM),
> 		.sin_addr.s_addr = inet_addr("127.0.0.1"),
> 	};
> 	struct timespec ts_start, ts_stop, ts_diff;
> 	uint8_t *payload;
> 	unsigned int num_chunks = 10000;
> 	unsigned int chunksize = 150;
> 	int conn_fd, ret;
> 
> 	while (1) {
> 		int option_index = 0, c;
> 		const struct option long_options[] = {
> 			{ "num-chunks", 1, 0, 'n' },
> 			{ "chunk-size", 1, 0, 's' },
> 			{ 0, 0, 0, 0 }
> 		};
> 
> 		c = getopt_long(argc, argv, "n:s:", long_options, &option_index);
> 		if (c == -1)
> 			break;
> 
> 		switch (c) {
> 		case 'n':
> 			num_chunks = atoi(optarg);
> 			break;
> 		case 's':
> 			chunksize = atoi(optarg);
> 			break;
> 		default:
> 			break;
> 		}
> 	}
> 
> 	printf("About to send %u chunks of each %u bytes\n", num_chunks, chunksize);
> 
> 	payload = malloc(chunksize);
> 	if (!payload)
> 		die("malloc()");
> 
> 	conn_fd = ext_socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
> 	if (conn_fd < 0)
> 		die("socket()");
> 
> 	ret = ext_connect(conn_fd, (struct sockaddr *) &servaddr, sizeof(servaddr));
> 	if (ret < 0)
> 		die("connect()");
> 
> 	ret = clock_gettime(CLOCK_MONOTONIC_RAW, &ts_start);
> 	if (ret < 0)
> 		die("clock_gettime()");
> 
> 	for (int i = 0; i < num_chunks; i++) {
> 		ret = sctp_sendmsg(conn_fd, payload, chunksize, NULL, 0, 0, 0, 0, 0, 0 );
> 		if (ret < 0)
> 			die("sctp_sendmsg");
> 	}
> 
> 	ret = clock_gettime(CLOCK_MONOTONIC_RAW, &ts_stop);
> 	if (ret < 0)
> 		die("clock_gettime()");
> 	timespec_diff(&ts_start, &ts_stop, &ts_diff);
> 	float diff_f = (float)ts_diff.tv_sec + (float)ts_diff.tv_nsec/1000000000.0;
> 	printf("%u DATA chunks of %u bytes each in %5.2f seconds: %5.2f DATA chunks per second\n",
> 		num_chunks, chunksize, diff_f, (float)num_chunks/diff_f);
> 
> 	close(conn_fd);
> 
> }
> 
> int main(int argc, char **argv) {
> 
> 	if (strstr(basename(argv[0]), "server"))
> 		server(argc, argv);
> 	else
> 		client(argc, argv);
> 
> 	return 0;
> }


-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
