Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C79D1F0AD4
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgFGK4h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 06:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgFGK4h (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jun 2020 06:56:37 -0400
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 Jun 2020 03:56:37 PDT
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CCFC08C5C2
        for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2020 03:56:37 -0700 (PDT)
Received: from [IPv6:2a02:8109:1140:c3d:bddf:742e:78b5:d32e] (unknown [IPv6:2a02:8109:1140:c3d:bddf:742e:78b5:d32e])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 57E517220B810
        for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2020 12:49:40 +0200 (CEST)
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: packed structures used in socket options
Message-Id: <CBFEFEF1-127A-4ADA-B438-B171B9E26282@lurchi.franken.de>
Date:   Sun, 7 Jun 2020 12:49:39 +0200
To:     linux-sctp@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dear all,

since gcc uses -Werror=address-of-packed-member, I get warnings for my variant
of packetdrill, which supports SCTP.

Here is why:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sctp.h?h=v5.7
contains:

struct sctp_paddrparams {
	sctp_assoc_t		spp_assoc_id;
	struct sockaddr_storage	spp_address;
	__u32			spp_hbinterval;
	__u16			spp_pathmaxrxt;
	__u32			spp_pathmtu;
	__u32			spp_sackdelay;
	__u32			spp_flags;
	__u32			spp_ipv6_flowlabel;
	__u8			spp_dscp;
} __attribute__((packed, aligned(4)));

This structure is only used in the IPPROTO_SCTP level socket option SCTP_PEER_ADDR_PARAMS.
Why is it packed?

Accessing spp_address, spp_pathmtu, spp_sackdelay, spp_flags, and spp_ipv6_flowlabel
results in warnings related to -Werror=address-of-packed-member.

Am I supposed to access these fields via memcpy only?

Please note that a similar problem exists also with other structures in that file, I
used struct sctp_paddrparams as an example.

Best regards
Michael
