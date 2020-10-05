Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E684283C9F
	for <lists+linux-sctp@lfdr.de>; Mon,  5 Oct 2020 18:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgJEQjZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 5 Oct 2020 12:39:25 -0400
Received: from mail.fink.org ([79.134.252.20]:38278 "EHLO mail.fink.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgJEQjZ (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 5 Oct 2020 12:39:25 -0400
X-Footer: Zmluay5vcmc=
Received: from protopia.fink.org ([79.134.238.50])
        (authenticated user list@fink.org)
        by mail.fink.org (Kerio Connect 9.2.12 patch 1) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
        for linux-sctp@vger.kernel.org;
        Mon, 5 Oct 2020 18:39:23 +0200
From:   Andreas Fink <afink@list.fink.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Heartbeat on closed SCTP sockets?
Message-Id: <1FB70B30-857C-4CD9-A05C-4BA15F57B1D2@list.fink.org>
Date:   Mon, 5 Oct 2020 18:39:22 +0200
To:     linux-sctp@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello all,

We are trying to debug a very strange case here and would like to hear your input.

Here is what we have

1. we have a application which listens on a  point to multipoint SCTP socket
2. when a incoming connection comes in and it matches a preconfigured one, it peels of that socket and a separate thread is starting communication on the upper layer.
3. when it doesnt match, an abort is triggered (that part might not work yet though).


Now we have multiple connections to different vendors and we have traces where we can see that there was a temporary issue on the IP layer and associations get shutdown and restarted.
After the IP layer resolved, all connection came up except two which go to the same peer and vendor.

What we now see in netstat --sctp is:

we have a LISTEN on port 2010
we have a  association from port 2010 to the remote in status CLOSED

in tcpdump we see packets coming in from the remote and heartbeat being acknowledged. However our application is not answering to these packets and the status of the application shows SCTP being down.
In other words, my application sees the association down. Netstat shows the association as being closed but the kernel seems to continue to entertain this association by continue to send heartbeat ACK and not sending ABORT.

We now kill the application

What we now see in netstat --sctp is:
we no longer listen on port 2010
we have a closed association from port 2010 to the remote.

in tcpdump we however we STILL see packets coming in from the remote and heartbeat being acknowledged, even though no application is listening on this port and no userspace application is using that port.
We do not see any SHUTDOWN or INIT even if we restart the application.

Can anyone explain how this can be?

We are using kernel linux-image-5.4.0-0.bpo.4-amd64 from the Debian Backport repositiory on Debian 10.

The issue seems to be related that the remote side never closes the SCTP assoc but simply tries to restart the upper layers while other vendors time out on upper layers and restart the SCTP assoc.
Restarting it from my application outbound also didnt help. Kernel somehow still remembers there's something up where theres clearly not.

The only solution to get this assoc back alive is to reboot the whole machine it seems.

Thanks for any input.


