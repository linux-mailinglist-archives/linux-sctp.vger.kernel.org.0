Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B0227810
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Jul 2020 07:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGUFXd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 21 Jul 2020 01:23:33 -0400
Received: from verein.lst.de ([213.95.11.211]:50572 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGUFXc (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 21 Jul 2020 01:23:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B86216736F; Tue, 21 Jul 2020 07:23:26 +0200 (CEST)
Date:   Tue, 21 Jul 2020 07:23:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-can@vger.kernel.org, dccp@vger.kernel.org,
        linux-decnet-user@lists.sourceforge.net,
        linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org,
        mptcp@lists.01.org, lvs-devel@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
        tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org
Subject: Re: [PATCH 02/24] bpfilter: fix up a sparse annotation
Message-ID: <20200721052326.GA10071@lst.de>
References: <20200720124737.118617-1-hch@lst.de> <20200720124737.118617-3-hch@lst.de> <20200721024016.2talwdt5hjqvirr6@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721024016.2talwdt5hjqvirr6@ltop.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Jul 21, 2020 at 04:40:16AM +0200, Luc Van Oostenryck wrote:
> >  	req.pid = current->pid;
> >  	req.cmd = optname;
> > -	req.addr = (long __force __user)optval;
> > +	req.addr = (__force long)optval;
> 
> For casts to integers, even '__force' is not needed (since integers
> can't be dereferenced, the concept of address-space is meaningless
> for them, so it's never useful to warn when it's dropped and
> '__force' is thus not needed).

That's what I thought. but if I remove it here I actually do get a
warning:

CHECK   net/bpfilter/bpfilter_kern.c
net/bpfilter/bpfilter_kern.c:52:21: warning: cast removes address space '__user' of expression

Using this recent sparse build:

hch@brick:~/work/linux$ sparse --version
v0.6.2-49-g707c5017
